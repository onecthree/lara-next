
export default async function Home() {
  const env = process.env;
  const data = await fetch(`${env.BACKEND_URL}`).then( v => v.json());
  return (
    <ul>
        {data.map((order, index) => (
            <li key={index}>{order.name} dengan umur {order.age}</li>
        ))}
    </ul>
  );
}
